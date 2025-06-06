import satori, { React } from 'satori.js' // React is required by the `eval` below.

export async function run(input) {
  // This allows the JSX to bind to `data.*`.
  let data = input.data;
  let utils = {};

  let utils_js = input.utils_js;
  if (utils_js) {
    console.debug("Evaluating utils_js...");
    eval(utils_js);
    console.debug("...done.");
    console.debug("Object utils contains the following keys: " + Object.keys(utils));
  }

  let jsx_js = input.jsx_js;
  console.debug("Evaluating jsx_js...");
  let converted_jsx = eval(jsx_js);
  console.debug("...done.");

  let fonts = [];
  if (input.fonts && input.fonts.length > 0) {
    for (let i = 0; i < input.fonts.length; i++) {
      let font = input.fonts[i];
      if (!font) {
        continue;
      }
      await try_add_font(fonts, font);
    }
  }
  else {
    await try_add_font(fonts, input.default_font || "\"Segoe UI\", Roboto, \"Helvetica Neue\", Arial, sans-serif");
  }

  const svg = await satori(
    converted_jsx,
    {
      width: input.width,
      height: input.height,
      embedFont: input.embed_font ?? true,
      debug: input.debug,
      fonts,
      loadAdditionalAsset: async (code, segment) => {
        console.log("Load additional asset requested: " + code);
        if (code === 'emoji') {
          return undefined;
        }
  
        let font = await slipway_host.font(code);
        if (font && font.data) {
          return font.data.buffer;
        }
      }
    },
  );

  return {
    svg: svg,
  };
}

async function try_add_font(fonts, query) {
  let font_result = await slipway_host.font(query);
  if (font_result) {
    if (!(font_result.data instanceof Uint8Array)) {
      throw new Error("Expected font data to be a Uint8Array.");
    }

    fonts.push({
      name: font_result.family,
      data: font_result.data.buffer,
      weight: 400,
      style: 'normal',
    })
  }
}