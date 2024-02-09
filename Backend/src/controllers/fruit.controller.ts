import { Request, Response } from "express";
import { pool } from "../database";

export const getAllFruits = (req: Request, res: Response) => {
    pool.query("SELECT * FROM fruit", (error, results) => {
        if (error) throw error;
        res.status(200).json(results.rows);
    });
};
