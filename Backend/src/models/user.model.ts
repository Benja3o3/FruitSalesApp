import Joi from "joi";

export const User = Joi.object({
    username: Joi.string().required(),
    password: Joi.string().required(),
    type: Joi.string().required(),
});
