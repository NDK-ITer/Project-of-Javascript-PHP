import FieldController from "../controllers/FieldController";


const fieldRoute = require('express').Router();

fieldRoute.get('/', FieldController.GetAll)

export default fieldRoute