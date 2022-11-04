import { RequestHandler } from "express";

import { Language } from "../models/Model";

export const getAllLanguages: RequestHandler = async (req, res, next) => {
  const allLanguages: Language[] = await Language.findAll();
  return res
    .status(200)
    .json(allLanguages);
};
