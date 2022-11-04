import { RequestHandler } from "express";

import { Author } from "../models/Author";

export const getAllAuthor: RequestHandler = async (req, res, next) => {
  const allAuthors: Author[] = await Author.findAll();
  return res
    .status(200)
    .json( allAuthors );
};

export const getAuthorById: RequestHandler = async (req, res, next) => {
  const { id } = req.params;
  const author: Author | null = await Author.findByPk(id);
  return res
    .status(200)
    .json( author );
};
