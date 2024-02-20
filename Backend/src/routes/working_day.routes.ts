import { Router } from "express";
import {
    fruitsToWorkingDay,
    fruitsToWorkingDayByUserId,
    newWorkingDay,
} from "../controllers/working_day.controller";

const router = Router();

router.post("/toWorkingDay", fruitsToWorkingDay);
router.post("/toWorkingDayByUserId", fruitsToWorkingDayByUserId);
router.post("/workingDay", newWorkingDay);

export default router;
