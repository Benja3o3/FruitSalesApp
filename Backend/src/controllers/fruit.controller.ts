import { Request, Response } from "express";
import { pool } from "../database";

export const getAllFruits = (req: Request, res: Response) => {
    pool.query("SELECT * FROM fruit", (error, results) => {
        if (error) throw error;
        res.status(200).json(results.rows);
    });
};

export const getAllFruitSellByUserId = (req: Request, res: Response) => {
    const { user_id, working_day_id } = req.body;
    console.log(user_id, working_day_id);
    pool.query(
        `
    SELECT fruit.name AS name,
    fruit.price AS price,
    fruit.icon AS icon,
    fruit.id AS id,
    COUNT(*) - 1 AS cantidad
    FROM fruit_sell
    JOIN fruit ON fruit_sell.fruit_id = fruit.id
    JOIN working_day ON fruit_sell.working_day_id = working_day.id
    JOIN users ON fruit_sell.created_by = users.id
    WHERE users.id = ${user_id}
    AND working_day.id = ${working_day_id}
    GROUP BY fruit.id, fruit.name, fruit.price, fruit.icon;`,
        (error, results) => {
            if (error) throw error;
            res.status(200).json(results.rows);
        }
    );
};

export const getAllFruitSell = (req: Request, res: Response) => {
    const { working_day_id } = req.body;
    pool.query(
        `
    SELECT fruit.name AS name,
    fruit.price AS price,
    fruit.icon AS icon,
    COUNT(*) - 1 AS cantidad
    FROM fruit_sell
    JOIN fruit ON fruit_sell.fruit_id = fruit.id
    JOIN working_day ON fruit_sell.working_day_id = working_day.id
    JOIN users ON fruit_sell.created_by = users.id
    WHERE working_day.id = ${working_day_id}
    GROUP BY fruit.name, fruit.price, fruit.icon;`,
        (error, results) => {
            if (error) throw error;
            res.status(200).json(results.rows);
        }
    );
};
