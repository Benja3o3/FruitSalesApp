import { Router } from "express";
import {
    fruitsToWorkingDay,
    newWorkingDay,
} from "../controllers/working_day.controller";

const router = Router();

router.post("/toWorkingDay", fruitsToWorkingDay);
router.post("/workingDay", newWorkingDay);

export default router;
