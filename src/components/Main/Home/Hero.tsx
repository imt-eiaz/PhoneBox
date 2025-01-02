import Link from "next/link";
import Image from "next/image";
import { StyledHero } from "./Styled";
import { Box, Button, Stack, Typography } from "@mui/material";
import WhatsAppIcon from "@mui/icons-material/WhatsApp";

export default function Hero() {
  return (
    <StyledHero>
      <Stack gap={2}>
        <Typography variant="h4" fontWeight={800}>
          Where Tech Meets Excellences.
        </Typography>
        <Typography>
          PhoneBox, where your device&apos;s journey continues.s
        </Typography>
        <Stack display="flex" direction="row" flexWrap="wrap" gap={2}>
          <Link href="/services">
            <Button>Services</Button>
          </Link>
          <a href="https://wa.me/447771835383" target="_blank">
            <Button variant="outlined" startIcon={<WhatsAppIcon />}>
              Whatsapp
            </Button>
          </a>
        </Stack>
      </Stack>
      <Box display={{ xs: "none", md: "block" }} ml="auto" mt="30px" mb="60px">
        <Image
          src="/images/hero.jpg"
          alt=""
          style={{ width: "100%" }}
          width={500}
          height={399}
        />
      </Box>
    </StyledHero>
  );
}
