import { defineConfig } from 'vite'
import wasm from 'vite-plugin-wasm'

export default defineConfig({
  plugins: [wasm()],
  build: {
    target: 'esnext',
    rollupOptions: {
      input: {
        main: './index.html',
        mandelbrot: './src/mandelbrot.html',
        blop5: './src/blop5.html',
        mandelbox: './src/mandelbox.html',
      }
    }
  }
})
