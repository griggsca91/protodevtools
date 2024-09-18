import { defineConfig } from 'vite';
import { crx } from '@crxjs/vite-plugin';
import { resolve } from 'path';
import manifest from './public/manifest.json'


export default defineConfig({
  plugins: [
    crx({
      manifest,
    }),
  ],
  build: {
    rollupOptions: {
      input: {
        background: resolve(__dirname, 'src/background.js'),
        content_script: resolve(__dirname, 'src/content_script.js'),
        popup: resolve(__dirname, 'src/popup.js'),
      },
      output: {
        entryFileNames: '[name].js',
      },
    },
  },
});

