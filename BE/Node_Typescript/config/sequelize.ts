import { Sequelize } from 'sequelize-typescript';
import { Role } from '../models/'; // Import model Role

const sequelize = new Sequelize({
  // Cấu hình kết nối cơ sở dữ liệu
});

sequelize.addModels([Role]); // Thêm model Role vào Sequelize

export default sequelize;