-- CreateEnum
CREATE TYPE "Role" AS ENUM ('user', 'admin', 'superadmin');

-- CreateEnum
CREATE TYPE "Provider" AS ENUM ('google', 'github', 'credentials');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('male', 'female', 'transgender');

-- CreateEnum
CREATE TYPE "OnlineAppointmentStatus" AS ENUM ('pending', 'shipping', 'receited', 'reviewing', 'payment', 'repairing', 'returned', 'received', 'cancelled');

-- CreateEnum
CREATE TYPE "OfflineAppointmentStatus" AS ENUM ('pending', 'completed', 'cancelled');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'user',
    "image" TEXT NOT NULL DEFAULT 'https://shorturl.at/jnruF',
    "email" TEXT NOT NULL,
    "password" TEXT,
    "phone" TEXT,
    "address" TEXT,
    "birthdate" TIMESTAMP(3),
    "gender" "Gender",
    "provider" "Provider" NOT NULL DEFAULT 'credentials',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admins" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'admin',
    "title" TEXT,
    "image" TEXT NOT NULL DEFAULT 'https://shorturl.at/jnruF',
    "email" TEXT NOT NULL,
    "password" TEXT,
    "phone" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "admins_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "services" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "estimatetime" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "online_appointments" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "deviceInfo" TEXT NOT NULL,
    "issueDescription" TEXT NOT NULL,
    "shippingAddress" TEXT NOT NULL,
    "status" "OnlineAppointmentStatus" NOT NULL DEFAULT 'pending',
    "paymentAmount" DOUBLE PRECISION,
    "issueDetected" TEXT[],
    "deliveryDate" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "online_appointments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "offline_appointments" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "deviceInfo" TEXT NOT NULL,
    "issueDescription" TEXT NOT NULL,
    "appointmentDate" TIMESTAMP(3) NOT NULL,
    "status" "OfflineAppointmentStatus" NOT NULL DEFAULT 'pending',
    "paymentAmount" DOUBLE PRECISION,
    "issueDetected" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "offline_appointments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "device_shipping" (
    "id" TEXT NOT NULL,
    "onlineAppointmentId" TEXT NOT NULL,
    "courierName" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "receiptDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "device_shipping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" TEXT NOT NULL,
    "onlineAppointmentId" TEXT NOT NULL,
    "method" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "transactionId" TEXT NOT NULL,
    "paymentDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "device_returned" (
    "id" TEXT NOT NULL,
    "onlineAppointmentId" TEXT NOT NULL,
    "courierName" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "receiptDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "device_returned_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reviews" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL,
    "comment" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blogs" (
    "id" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "publishedDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "blogs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "faqs" (
    "id" TEXT NOT NULL,
    "serial" SERIAL NOT NULL,
    "question" TEXT NOT NULL,
    "answer" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "faqs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "admins_email_key" ON "admins"("email");

-- CreateIndex
CREATE UNIQUE INDEX "device_shipping_onlineAppointmentId_key" ON "device_shipping"("onlineAppointmentId");

-- CreateIndex
CREATE UNIQUE INDEX "payments_onlineAppointmentId_key" ON "payments"("onlineAppointmentId");

-- CreateIndex
CREATE UNIQUE INDEX "device_returned_onlineAppointmentId_key" ON "device_returned"("onlineAppointmentId");

-- AddForeignKey
ALTER TABLE "online_appointments" ADD CONSTRAINT "online_appointments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "online_appointments" ADD CONSTRAINT "online_appointments_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_appointments" ADD CONSTRAINT "offline_appointments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_appointments" ADD CONSTRAINT "offline_appointments_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "device_shipping" ADD CONSTRAINT "device_shipping_onlineAppointmentId_fkey" FOREIGN KEY ("onlineAppointmentId") REFERENCES "online_appointments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_onlineAppointmentId_fkey" FOREIGN KEY ("onlineAppointmentId") REFERENCES "online_appointments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "device_returned" ADD CONSTRAINT "device_returned_onlineAppointmentId_fkey" FOREIGN KEY ("onlineAppointmentId") REFERENCES "online_appointments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
