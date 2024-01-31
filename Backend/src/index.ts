import { App } from "./app";

function main() {
    const app = new App();
    app.listen();
    app.connect_database();
}

main();
