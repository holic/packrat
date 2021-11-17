import { Controller } from "@hotwired/stimulus"

const { ethers } = window.ethers;
// TODO: move url to env variable?
const provider = new ethers.providers.JsonRpcProvider('https://eth-mainnet.alchemyapi.io/v2/myMIF-xBCZ_bDBBZO33cFsgm4jAO0qhV');

export default class extends Controller {
  static values = {
    address: String,
  }

  async addressValueChanged() {
    // TODO: cache lookups in localStorage/sessionStorage and use those instead

    const address = this.addressValue;
    const ensName = await provider.lookupAddress(address);

    this.element.innerText = ensName || address.replace(/^(.{5}).+(.{4})$/,'$1…2');
  }
}
