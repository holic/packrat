import { Controller } from "@hotwired/stimulus"

const { ethers } = window.ethers;
const Web3Modal = window.Web3Modal.default;

const providerOptions = {
  /* See Provider Options Section */
};

const web3Modal = new Web3Modal({
  network: "mainnet",
  cacheProvider: true,
  providerOptions
});


export default class extends Controller {
  static targets = ['container', 'connectButton', 'wallet', 'walletAddress'];
  static values = { wallet: { type: String, default: localStorage.getItem('wallet') || '' } };

  walletValueChanged() {
    console.log('wallet changed to', this.walletValue)
    if (this.walletValue) {
      this.connectButtonTarget.classList.add('hidden');
      this.walletTarget.classList.remove('hidden');
      this.walletAddressTarget.innerText = this.walletValue;
    }
    else {
      this.walletTarget.classList.add('hidden');
      this.connectButtonTarget.classList.remove('hidden');
    }
  }

  async connect() {
    // If we have a cached provider (wallet connected before), connect to it now before we reveal the wallet section
    if (web3Modal.cachedProvider) {
      await this.connectWallet();
    }

    this.containerTarget.classList.remove('hidden');
  }

  async connectWallet() {
    const web3ModalProvider = await web3Modal.connect();
    // TODO: listen to provider events

    const provider = new ethers.providers.Web3Provider(web3ModalProvider);
    const signer = provider.getSigner();
    const address = await signer.getAddress();
    const ensName = await provider.lookupAddress(address);
    
    this.walletValue = ensName || address;
  }
}