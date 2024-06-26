//connect to a postgresql database
import { Pool } from "pg";
import dotenv from "dotenv";
dotenv.config();

export const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASS,
    port: 5432,
    // connectionString: process.env.DB_URL,
    // ssl: true,
});
