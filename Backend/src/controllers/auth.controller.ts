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
    if (!(await verifyPassword(req.body.password, founded_user.password))) {
        return res.status(400).json({ message: "Invalid user" });
    }
    const token = jwt.sign(
        { username: founded_user.username, type: founded_user.type },
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
