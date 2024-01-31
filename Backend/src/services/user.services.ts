import { pool } from "../database";
import { UserInterface } from "../interfaces";
import bcrypt from "bcrypt";

export const getUserByUsername = (username: string): Promise<any> => {
    return new Promise((resolve, reject) => {
        pool.query(
            `SELECT * FROM users WHERE username = '${username}'`,
            (error, result) => {
                if (error) {
                    console.log("Error in the query: ", error);
                    reject("Error in the query");
                }
                resolve(result.rows[0]);
            }
        );
    });
};

export const createUser = async (user: UserInterface): Promise<any> => {
    const hashedPassword = await bcrypt.hash(user.password, 10);
    return new Promise((resolve, reject) => {
        pool.query(
            `
        INSERT INTO users (username, password, type)
        VALUES ('${user.username}', '${hashedPassword}', '${user.type}')
        `,
            (error, result) => {
                if (error) {
                    console.log("Error in the query: ", error);
                    reject({ message: "Error in the query" });
                }
                resolve({ message: "User created" });
            }
        );
    });
};

export const verifyPassword = async (
    password: string,
    real_password: string
) => {
    return await bcrypt.compare(password, real_password);
};
