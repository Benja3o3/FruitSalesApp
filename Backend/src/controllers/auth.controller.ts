import { Request, Response } from "express";
import { pool } from "../database";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import { User } from "../models/user.model";
import {
    createUser,
    getUserByUsername,
    verifyPassword,
} from "../services/user.services";

export const loginHandler = async (req: Request, res: Response) => {
    if (!req.body.username || !req.body.password)
        return res.status(400).json({ message: "Invalid user" });
    const founded_user = await getUserByUsername(req.body.username);
    if (!founded_user)
        return res.status(401).json({ message: "User not found" });
    if (!(await verifyPassword(req.body.password, founded_user.password))) {
        return res.status(400).json({ message: "Invalid user" });
    }
    const token = jwt.sign(
        {
            id: founded_user.id,
            username: founded_user.username,
            type: founded_user.type,
        },
        "secret",
        {
            expiresIn: 60 * 60 * 24,
        }
    );
    return res.json({ token });
};

export const registerHandler = async (req: Request, res: Response) => {
    const { error, value } = User.validate(req.body);
    if (error) return res.status(400).json({ message: "Invalid user" });
    const founded_user = await getUserByUsername(value.username);
    if (founded_user)
        return res.status(400).json({ message: "User already exists" });
    const hashedPassword = await bcrypt.hash(value.password, 10);
    await createUser(value);
    return res.json({ message: "User created" });
};

export const profileHandler = (req: Request, res: Response) => {
    res.json(req.body.user);
};

export const initDatabase = async (req: Request, res: Response) => {
    pool.query(
        `
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        username varchar(255) NOT NULL,
        password varchar(255) NOT NULL,
        type varchar(255) NOT NULL
      );
      
      CREATE TABLE IF NOT EXISTS working_day (
        id SERIAL PRIMARY KEY,
        date timestamp NOT NULL
      );
      
      CREATE TABLE IF NOT EXISTS fruit (
        id SERIAL PRIMARY KEY,
        name varchar(255) NOT NULL,
        price int NOT NULL,
        icon varchar(255) NOT NULL
      );
      
      CREATE TABLE IF NOT EXISTS position_history (
        id SERIAL PRIMARY KEY,
        coordinates point NOT NULL,
        user_id int NOT NULL,
        working_day_id int NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
        FOREIGN KEY (working_day_id) REFERENCES working_day(id) ON DELETE RESTRICT ON UPDATE RESTRICT
      );
      
      CREATE TABLE IF NOT EXISTS fruit_sell (
        id SERIAL PRIMARY KEY,
        created_by int NOT NULL,
        fruit_id int NOT NULL,
        working_day_id int NOT NULL,
        FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
        FOREIGN KEY (fruit_id) REFERENCES fruit(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
        FOREIGN KEY (working_day_id) REFERENCES working_day(id) ON DELETE RESTRICT ON UPDATE RESTRICT
      );
      
      
      CREATE TABLE IF NOT EXISTS working_day_user (
        id SERIAL PRIMARY KEY,
        working_day_id int NOT NULL,
        user_id int NOT NULL,
        FOREIGN KEY (working_day_id) REFERENCES working_day(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT
      );
      
      CREATE TABLE IF NOT EXISTS current_position (
        id SERIAL PRIMARY KEY,
        latitude float NOT NULL,
        longitude float NOT NULL,
        user_id int NOT NULL,
        working_day_id int NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
        FOREIGN KEY (working_day_id) REFERENCES working_day(id) ON DELETE RESTRICT ON UPDATE RESTRICT
      );
      
      INSERT INTO users VALUES (DEFAULT, 'admin', '$2b$10$rgLWiEIs1HdDJHwZIc.U1ubfnne03WRtZbYgrQELsmdG6gRtSEdsS', 'vendedor'); 
      
      INSERT INTO fruit 
      VALUES
      (DEFAULT, 'Frambuesa', 3000, 'frambuesa.png'), 
      (DEFAULT, 'Frutilla', 2000, 'frutilla.png'), 
      (DEFAULT, 'Arandano', 2500, 'arandano.png'), 
      (DEFAULT, 'Melon', 2500, 'melon.png');
    `,
        (error, results) => {
            if (error) {
                console.log(error);
                return res
                    .status(500)
                    .json({ message: "Error initializing database" });
            }
            return res.json({ message: "Database initialized" });
        }
    );
};
