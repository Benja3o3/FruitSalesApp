import { Router } from "express";
import {
    initDatabase,
    loginHandler,
    profileHandler,
    registerHandler,
} from "../controllers/auth.controller";
import { requiredAuth } from "../middlewares/requiredAuth";

const router = Router();

router.post("/login", loginHandler);
router.post("/register", registerHandler);
router.get("/profile", requiredAuth, profileHandler);
router.get("/init", initDatabase);

export default router;
