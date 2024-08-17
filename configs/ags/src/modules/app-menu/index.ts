import type { Application } from "resource:///com/github/Aylur/ags/service/applications.js";

const { query } = await Service.import("applications");

const WINDOW_NAME = "app-launcher";

const closeApp = () => App.closeWindow(WINDOW_NAME);

function AppButton(app: Application) {
  return Widget.Button({
    attribute: app,
    on_clicked() {
      closeApp();
      app.launch();
    },
    child: Widget.Box({
      children: [
        Widget.Icon({ icon: app.icon_name || "", size: 42 }),
        Widget.Label({
          class_name: "title",
          label: app.name,
          xalign: 0,
          vpack: "center",
          truncate: "end",
        }),
      ],
    }),
  });
}

const getApps = () => query("").map(AppButton);

function AppLauncher() {
  const spacing = 10;
  let apps = getApps();

  const list = Widget.Box({
    spacing,
    vertical: true,
    children: apps,
  });

  const searchBar = Widget.Entry({
    hexpand: true,
    css: `margin-top: ${spacing}px; margin-bottom: ${spacing}px;`,
    on_accept() {
      const result = apps.filter((item) => item.visible)[0];
      if (result) {
        App.toggleWindow(WINDOW_NAME);
        result.attribute.launch();
      }
    },
    on_change({ text }) {
      for (const item of apps) {
        item.visible = item.attribute.match(text ?? "");
      }
    },
  });

  function resetSearchBar(focus = true) {
    searchBar.text = "";
    if (focus) searchBar.grab_focus();
  }

  return Widget.Window({
    name: WINDOW_NAME,
    visible: false,
    keymode: "exclusive",
    setup(self) {
      self.keybind("Escape", () => {
        closeApp();
        resetSearchBar();
      });
    },
    child: Widget.Box({
      vertical: true,
      css: `margin: ${spacing * 2}px;`,
      spacing: spacing * 2,
      children: [
        searchBar,
        Widget.Scrollable({
          hscroll: "never",
          css: "min-width: 500px; min-height: 500px;",
          child: list,
        }),
      ],
      setup(self) {
        self.hook(App, (_, windowName: string, visible: boolean) => {
          if (windowName !== WINDOW_NAME && visible) {
            apps = getApps();
            list.children = apps;
            resetSearchBar();
          }
        });
      },
    }),
  });
}

export default AppLauncher;
