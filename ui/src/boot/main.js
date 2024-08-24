import { boot } from 'quasar/wrappers';
import { Buffer } from 'buffer';

// more info on params: https://v2.quasar.dev/quasar-cli/boot-files
export default boot(async (/* { app, router, ... } */) => {
  process.browser = true;
  window.Buffer = Buffer;

  BigInt.prototype.toJSON = function () {
    return this.toString();
  };
});
