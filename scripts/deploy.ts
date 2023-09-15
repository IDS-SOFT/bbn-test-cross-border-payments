import { ethers } from "hardhat";

async function main() {

  const crossBorderPayment = await ethers.deployContract("CrossBorderPayment");

  await crossBorderPayment.waitForDeployment();

  console.log("CrossBorderPayment deployed to : ",await crossBorderPayment.getAddress());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
