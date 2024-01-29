import { Router } from "express";

const router = Router();

router.get("/", (req, res) => {
    return res.json({ message: "The api is running" });
});

export default router;
