import { Controller } from "@hotwired/stimulus"
import { ensNameOrAddress } from '../ens';

const { ethers } = window.ethers;
const Web3Modal = window.Web3Modal.default;

const web3Modal = new Web3Modal({
  network: "mainnet",
  cacheProvider: true,
});

const LOGIN_BUTTON_TEXT = 'Log in';

export default class extends Controller {
  static values = {
    csrf: String,
  }

  swapLoginButton() {
    this.element.innerText = LOGIN_BUTTON_TEXT;
  }

  async walletValueChanged() {
    console.log('wallet changed to', this.walletValue);
    if (this.walletValue) {
      this.connectButtonTarget.classList.add('hidden');
      this.walletTarget.classList.remove('hidden');

      // TODO: clean this up
      const address = this.walletValue;
      this.walletAddressTarget.innerText = address;

      if (web3Modal.cachedProvider) {
        const web3ModalProvider = await web3Modal.connect();
        const provider = new ethers.providers.Web3Provider(web3ModalProvider);
        const ensName = await provider.lookupAddress(address);
        if (ensName) {
          this.walletAddressTarget.innerText = ensName;
        }
      }
    }
    else {
      this.walletTarget.classList.add('hidden');
      this.connectButtonTarget.classList.remove('hidden');
    }
  }

  async connect() {
    // If we have a cached provider (wallet connected before), connect to it now before we reveal the wallet section
    if (web3Modal.cachedProvider) {
      this.swapLoginButton();
    }
  }

  async connectWallet() {
    const web3ModalProvider = await web3Modal.connect();

    if (this.element.innerText === LOGIN_BUTTON_TEXT) {
      await this.login(web3ModalProvider);
      return;
    }

    // TODO: listen to provider events
    this.swapLoginButton();
  }

  async login(web3ModalProvider) {
    const provider = new ethers.providers.Web3Provider(web3ModalProvider);
    const signer = provider.getSigner();
    const address = await signer.getAddress();

    // prime cache
    ensNameOrAddress(address);

    const message = `To log in to Packrat, we need to verify that you are the owner of this wallet. Sign this message to log in! You'll only have to do this once per day.\n\n\n${this.csrfValue}`;
    const signature = await signer.signMessage(message);

    const formData = new FormData();
    formData.set('message', message);
    formData.set('signature', signature);

    const json = await fetch('/session', {
        method: 'POST',
        credentials: 'same-origin',
        headers: {
          'X-CSRF-Token': this.csrfValue,
        },
        body: formData,
      })
      .then((res) => res.json());

    console.log('created session', json);
    
    if (address === json.address) {
      window.location.reload();
    } else {
      alert('Oops, could not log you in.');
    }
  }
}