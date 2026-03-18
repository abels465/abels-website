import * as wasm from "./runner_bg.wasm";
export * from "./runner_bg.js";
import { __wbg_set_wasm } from "./runner_bg.js";
__wbg_set_wasm(wasm);
wasm.__wbindgen_start();
