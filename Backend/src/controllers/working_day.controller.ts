import { Request, Response } from "express";
import { pool } from "../database";

export const fruitsToWorkingDay = async (req: Request, res: Response) => {
    const { working_day_id, fruit_id, created_by } = req.body;
    const promises: Promise<string>[] = [];

    fruit_id.forEach((id: number) => {
        const promise = new Promise<string>((resolve, reject) => {
            pool.query(
                `
                INSERT INTO working_day_fruit (id, working_day_id, fruit_id, created_by)
                VALUES (DEFAULT, ${working_day_id}, ${id}, ${created_by});
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
