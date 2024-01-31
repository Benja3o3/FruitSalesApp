import { Router } from "express";
import {
    loginHandler,
    profileHandler,
    registerHandler,
} from "../controllers/auth.controller";
import { requiredAuth } from "../middlewares/requiredAuth";

const router = Router();

router.post("/login", loginHandler);
router.post("/register", registerHandler);
router.get("/profile", requiredAuth, profileHandler);

export default router;
