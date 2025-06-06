publisher := "slipwayhq"

build: clean wit && (package "jsx") (package "jsx__svg") cargo-build (assemble "jsx_transpile" "jsx__transpile") (package "jsx__transpile")
build-ci: clean && (package-ci "jsx") (package-ci "jsx__svg") cargo-build (assemble "jsx_transpile" "jsx__transpile") (package-ci "jsx__transpile")
  rustup target add wasm32-wasip2

clean:
  rm -f components/*.tar
  rm -f components/{{publisher}}.jsx__transpile/run.wasm

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
