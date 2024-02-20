import { Request, Response } from "express";
import { pool } from "../database";

export const fruitsToWorkingDay = async (req: Request, res: Response) => {
    const { working_day_id, fruit_id, created_by } = req.body;
    const promises: Promise<string>[] = [];

    fruit_id.forEach((id: number) => {
        const promise = new Promise<string>((resolve, reject) => {
            pool.query(
                `
                INSERT INTO fruit_sell (id, created_by, fruit_id, working_day_id)
                VALUES (DEFAULT, ${created_by}, ${id}, ${working_day_id});
                `,
                (error, results) => {
                    if (error) {
                        reject(error);
                    } else {
                        resolve(`Working day added with fruit ${id}`);
                    }
                }
            );
        });
        promises.push(promise);
    });

    try {
        await Promise.all(promises);
        res.status(200).send("All fruits added to working day");
    } catch (error) {
        res.status(500).send("Error adding fruits to working day");
    }
};

export const newWorkingDay = async (req: Request, res: Response) => {
    const { id } = req.body;
    pool.query(
        `
    INSERT INTO working_day (id, date)
    VALUES (${id}, CURRENT_TIMESTAMP);
    `,
        (error, results) => {
            if (error) throw error;
            res.status(200).send(`Working day added`);
        }
    );
};

export const fruitsToWorkingDayByUserId = async (
    req: Request,
    res: Response
) => {
    const { user_id, working_day_id } = req.body;
    pool.query(
        `
    INSERT INTO fruit_sell (created_by, fruit_id, working_day_id)
    SELECT ${user_id}, fruit_id, working_day_id
    FROM fruit_sell
    WHERE working_day_id = ${working_day_id} AND created_by = 1;
    `,
        (error, results) => {
            if (error) throw error;
            res.status(200).send(`Fruits added to working day`);
        }
    );
};
