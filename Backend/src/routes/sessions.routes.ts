import { Router } from "express";

const router = Router();

router.get("/sessions", (req, res) => {
    return res.json({ message: "The api is running" });
});

export default router;
