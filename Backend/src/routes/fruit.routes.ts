import { Router } from "express";
import { getAllFruits } from "../controllers/fruit.controller";

const router = Router();

router.get("/fruit", getAllFruits);

export default router;
