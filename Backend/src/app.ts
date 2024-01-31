import express, { Application } from "express";
import { pool } from "./database";
import cors from "cors";
import IndexRoutes from "./routes/index.routes";
import SessionsRoutes from "./routes/sessions.routes";
import AuthRoutes from "./routes/auth.routes";

export class App {
    private app: Application; //Construye una aplicacion servidor de express

    constructor(private port?: number | string) {
        this.app = express(); //Se construye la App
        this.middlewares();
        this.settings();
        this.routes();
    }

    settings() {
        this.app.set("port", this.port || process.env.PORT || 8000); //Se define el puerto
    }

    routes() {
        this.app.use(IndexRoutes); //Se usa el archivo de rutas
        this.app.use(SessionsRoutes);
        this.app.use(AuthRoutes);
    }

    middlewares() {
        this.app.use(cors()); //Se usan los cors
        this.app.use(express.json()); //Para que el backend entienda los .json
        this.app.use(express.urlencoded({ extended: false }));
    }

    async listen() {
        await this.app.listen(this.app.get("port")); //Funcion para inicializar el servidor
        console.log("Server on port " + this.app.get("port"));
    }
    async connect_database() {
        await pool.connect();
        console.log("Database connected");
    }
}
