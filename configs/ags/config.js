// @ts-nocheck

async function compileAndLoad() {
  const target = "/tmp/ags/main.js";

  await Utils.execAsync([
    "esbuild",
    "--bundle",
    `${App.configDir}/config.ts`,
    "--format=esm",
    `--outfile=${target}`,
    "--external:resource://*",
    "--external:gi://*",
    "--external:file://*",
  ]);

  await import(`file://${target}`);
}

try {
  await compileAndLoad();
} catch (error) {
  console.error(error);
}
