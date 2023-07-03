import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";
import permission from "./directive/permission";

import "./assets/style/app.scss";

const pinia = createPinia();
const app = createApp(App);

app.use(pinia);
app.use(router);
app.directive("permission", permission);

app.mount("#app");
