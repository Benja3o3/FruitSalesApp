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

export const addFruitSell = (req: Request, res: Response) => {
    const { user_id, fruit_id, working_day_id } = req.body;
    pool.query(
        `
    INSERT INTO fruit_sell (id, created_by, fruit_id, working_day_id)
    VALUES (DEFAULT, ${user_id}, ${fruit_id}, ${working_day_id});
    `,
        (error, results) => {
            if (error) throw error;
            res.status(200).json({ message: "Fruit added successfully" });
        }
    );
};

export const deleteFruitSell = (req: Request, res: Response) => {
    const { user_id, fruit_id, working_day_id } = req.body;
    pool.query(
        `
    WITH LastFruitSell AS (
        SELECT id
        FROM fruit_sell
        WHERE working_day_id = ${working_day_id}
          AND created_by = ${user_id}
          AND fruit_id = ${fruit_id}
        ORDER BY id DESC
        LIMIT 1
    )
    DELETE FROM fruit_sell
    WHERE id = (SELECT id FROM LastFruitSell);
    `,
        (error, results) => {
            if (error) throw error;
            res.status(200).json({ message: "Fruit deleted successfully" });
        }
    );
};

export const getFruitTotals = (req: Request, res: Response) => {
    const { working_day_id, user_id } = req.body;
    pool.query(
        `
    SELECT 
    (COUNT(*) - COUNT(DISTINCT fruit_id)) AS totalPotes,
    SUM(price) - 
        (
        SELECT SUM(price)
        FROM fruit
        WHERE id IN (
            SELECT DISTINCT fruit_id
            FROM fruit_sell
            WHERE working_day_id = 468159
            GROUP BY fruit_id
            )
        ) AS totalDinero
    FROM fruit_sell
    JOIN fruit ON fruit_sell.fruit_id = fruit.id
    WHERE working_day_id = ${working_day_id}
    AND created_by = ${user_id}; 
    `,
        (error, results) => {
            if (error) throw error;
            res.status(200).json(results.rows[0]);
        }
    );
};
