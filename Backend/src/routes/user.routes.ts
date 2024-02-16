import { Router } from "express";
import { changeType } from "../controllers/user.controller";

const router = Router();

router.put("/type", changeType);

export default router;
