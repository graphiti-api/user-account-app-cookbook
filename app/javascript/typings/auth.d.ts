/**
 * Augment the typings of Vue.js
 */

import Vue from "vue";
import { IAuth } from '../auth'

declare module "vue/types/vue" {
  interface Vue {
    $auth: IAuth;
  }
}
