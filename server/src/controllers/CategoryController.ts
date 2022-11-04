import { RequestHandler } from "express";

import { Category } from "../models/Model";

export const getAllCategories: RequestHandler = async (req, res, next) => {
  const allCategories: Category[] = await Category.findAll();
  return res
    .status(200)
    .json(allCategories);
};

