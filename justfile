publisher := "hgmich"

build: clean wit && (package "jsx_experimental") (package "jsx_experimental__svg") cargo-build (assemble "jsx_experimental_transpile" "jsx_experimental__transpile") (package "jsx_experimental__transpile")
build-ci: clean && (package-ci "jsx_experimental") (package-ci "jsx_experimental__svg") cargo-build (assemble "jsx_experimental_transpile" "jsx_experimental__transpile") (package-ci "jsx_experimental__transpile")
  rustup target add wasm32-wasip2

clean:
  rm -f components/*.tar
  rm -f components/{{publisher}}.jsx_experimental__transpile/run.wasm

package name:
  slipway package components/{{publisher}}.{{name}}

package-ci name:
  docker run --rm -v "$(pwd)/components":/workspace -w /workspace slipwayhq/slipway:latest slipway package {{publisher}}.{{name}}

cargo-build configuration="release":
  cd src && cargo build --target wasm32-wasip2 {{ if configuration == "release" { "--release" } else { "" } }}

assemble rustname name configuration="release":
  cp target/wasm32-wasip2/{{configuration}}/slipway_{{rustname}}.wasm components/{{publisher}}.{{name}}/run.wasm

wit:
  slipway wit > wit/slipway.wit

test: build
  cargo test

release version:
  git tag -a "{{version}}" -m "Release {{version}}"
  git push origin "{{version}}"
