import StatusBar from "./modules/status-bar/index";
import AppMenu from "./modules/app-menu/index";
import PowerMenu from "modules/power-menu/index";

App.config({
  windows: [StatusBar(), AppMenu(), PowerMenu()],
});
