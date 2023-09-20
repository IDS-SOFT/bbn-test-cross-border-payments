import { ethers } from "hardhat";

const recipient = "0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199";
const tokenAddress  = "0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199";
const amount = 100;

async function main() {

  const crossBorderPayment = await ethers.deployContract("CrossBorderPayment",[recipient, tokenAddress, amount]);

  await crossBorderPayment.waitForDeployment();

  console.log("CrossBorderPayment deployed to : ",await crossBorderPayment.getAddress());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
