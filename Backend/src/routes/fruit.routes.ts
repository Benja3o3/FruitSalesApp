import { Router } from "express";
import {
    addFruitSell,
    deleteFruitSell,
    getAllFruitSell,
    getAllFruitSellByUserId,
    getAllFruits,
    getFruitTotals,
} from "../controllers/fruit.controller";

const router = Router();

router.get("/fruit", getAllFruits);
router.get("/fruitUserSell", getAllFruitSellByUserId);
router.get("/fruitSell", getAllFruitSell);
router.post("/fruitSell", addFruitSell);
router.delete("/fruitSell", deleteFruitSell);
router.get("/fruitTotals", getFruitTotals);

export default router;
