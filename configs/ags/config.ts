import AppMenu from "./widgets/AppMenu";
import PowerMenu from "./widgets/PowerMenu";
import StatusBar from "./widgets/StatusBar";

App.config({
  windows: [StatusBar(), AppMenu(), PowerMenu()],
});
