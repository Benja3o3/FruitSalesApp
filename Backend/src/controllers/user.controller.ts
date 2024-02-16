import { pool } from "../database";
import { Request, Response } from "express";

export const changeType = async (req: Request, res: Response) => {
    const { user_id, type } = req.body;
    pool.query(
        `
    UPDATE users
    SET type = '${type}'
    WHERE id = ${user_id};
    `,
        (error, results) => {
            if (error) {
                throw error;
            }
            res.status(200).json(results.rows);
        }
    );
};
