import esbuild from "esbuild";

esbuild.build({
    entryPoints: ["src/scss/bulma-theme.scss", "src/assets/js/main.js"],
    outdir: "dist",
    bundle: true,
    plugins: [],
})
.then(() => console.log("⚡ Build complete! ⚡"))
.catch(() => process.exit(1));
