import { Router } from "express";
import {
    getAllFruitSell,
    getAllFruitSellByUserId,
    getAllFruits,
} from "../controllers/fruit.controller";

const router = Router();

router.get("/fruit", getAllFruits);
router.get("/fruitUserSell", getAllFruitSellByUserId);
router.get("/fruitSell", getAllFruitSell);

export default router;
