import { Router } from "express";
import {
    addCurrentPosition,
    addPositionHistory,
    getCurrentPositions,
    getPositionHistory,
    updateCurrentPosition,
} from "../controllers/position.controller";

const router = Router();

router.get("/currentPositions", getCurrentPositions);
router.post("/currentPositions", addCurrentPosition);
router.put("/currentPositions", updateCurrentPosition);
router.get("/positionHistory", getPositionHistory);
router.post("/positionHistory", addPositionHistory);

export default router;
