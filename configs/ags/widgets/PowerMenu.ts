const options = [
  {
    label: "Lock",
    action: "loginctl lock-session",
    keybind: "l",
    icon: "lock",
  },
  {
    label: "Logout",
    action: "loginctl terminate-user $USER",
    keybind: "e",
    icon: "system-log-out",
  },
  {
    label: "Power Off",
    action: "systemctl poweroff",
    keybind: "s",
    icon: "system-shutdown",
  },
  {
    label: "Reboot",
    action: "systemctl reboot",
    keybind: "r",
    icon: "system-reboot",
  },
];

const WINDOW_NAME = "power-menu";
const spacing = 10;

const closeWindow = () => App.closeWindow(WINDOW_NAME);

function MenuItem({ icon, label, action, keybind }: (typeof options)[number]) {
  async function execAction() {
    try {
      await Utils.execAsync(action);
    } catch (error) {
      console.error(error);
    } finally {
      closeWindow();
    }
  }

  return Widget.Button({
    setup(self) {
      // @ts-ignore
      self.keybind(keybind, execAction);
    },
    onClicked: execAction,
    child: Widget.Box({
      vertical: true,
      spacing,
      css: `margin: ${spacing}px`,
      children: [
        Widget.Icon({ icon: `${icon}-symbolic`, size: 50 }),
        Widget.Label(`${label} (${keybind})`),
      ],
    }),
  });
}

export default function PowerMenu() {
  return Widget.Window({
    name: WINDOW_NAME,
    visible: false,
    keymode: "exclusive",
    setup(self) {
      self.keybind("Escape", closeWindow);
    },
    child: Widget.Box({
      spacing: spacing * 2,
      css: `margin: ${spacing * 2}px`,
      setup(self) {
        self.hook(App, (_, window: string, visible: boolean) => {
          if (window !== WINDOW_NAME && visible) closeWindow();
        });
      },
      children: options.map(MenuItem),
    }),
  });
}
