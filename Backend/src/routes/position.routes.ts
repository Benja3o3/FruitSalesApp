import { Router } from "express";
import {
    addCurrentPosition,
    getCurrentPositions,
    updateCurrentPosition,
} from "../controllers/position.controller";

const router = Router();

router.get("/currentPositions", getCurrentPositions);
router.post("/currentPositions", addCurrentPosition);
router.put("/currentPositions", updateCurrentPosition);

export default router;
