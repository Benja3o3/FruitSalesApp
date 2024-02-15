import { Request, Response } from "express";
import { pool } from "../database";

export const getCurrentPositions = async (req: Request, res: Response) => {
    const { working_day_id } = req.body;
    pool.query(
        `
    SELECT cp.latitude, cp.longitude, cp.user_id, u.type FROM current_position cp
    JOIN users u ON cp.user_id = u.id
    WHERE working_day_id = ${working_day_id};
    `,
        (error, results) => {
            if (error) {
                throw error;
            }
            res.status(200).json(results.rows);
        }
    );
};

export const addCurrentPosition = async (req: Request, res: Response) => {
    const { working_day_id, latitude, longitude, user_id } = req.body;
    pool.query(
        `
    INSERT INTO current_position (id, latitude, longitude, user_id, working_day_id) 
    VALUES (DEFAULT, ${latitude}, ${longitude}, ${user_id}, ${working_day_id});
    `,
        (error, results) => {
            if (error) {
                throw error;
            }
            res.status(201).send(`Position added`);
        }
    );
};

export const updateCurrentPosition = async (req: Request, res: Response) => {
    const { working_day_id, latitude, longitude, user_id } = req.body;
    pool.query(
        `
    UPDATE current_position 
    SET latitude = ${latitude}, longitude = ${longitude}
    WHERE user_id = ${user_id} AND working_day_id = ${working_day_id};
    `,
        (error, results) => {
            if (error) {
                throw error;
            }
            res.status(201).send(`Position updated`);
        }
    );
};
