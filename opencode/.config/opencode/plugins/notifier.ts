import type { Plugin } from "@opencode-ai/plugin";

export const NotificationPlugin: Plugin = async ({
  project,
  client,
  $,
  directory,
  worktree,
}) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        $`notify-send -i /usr/share/icons/Archcraft/categories/32/applications-development.svg  "OpenCode" "Waiting for task input"`;
      }
    },
  };
};
