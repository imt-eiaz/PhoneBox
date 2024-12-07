import prisma from "@/libs/prisma";
import { Prisma } from "@prisma/client";
//import Blogs from "@/components/Main/Blogs";
import Customers from "@/components/Main/Customers";
import { searchQuery } from "@/libs/searchQuery";
import Pagination from "@/components/Common/Pagination";

export const metadata = { title: "Customers" };

export default async function BlogPage({ searchParams }: { searchParams: { page?: string; search?: string } }) {
    const search = searchParams?.search ? searchParams.search : "";
    const page = Number(searchParams?.page ? searchParams.page : 1);

    const andConditions = [];
    if (search) andConditions.push(searchQuery(search, ["title", "content", "source"]));
    const where: Prisma.BlogWhereInput = { AND: andConditions };

    const customers = await prisma.blog.findMany({
        where,
        select: { id: true, image: true, source: true, publishedDate: true, title: true, content: true },
        skip: (page - 1) * 4,
        take: 4,
    });
    const total = await prisma.blog.count({ where });

    return (
        <>
            <Customers blogs={customers} />
            <Pagination page={page} count={Math.ceil(total / 4)} />
        </>
    );
}
