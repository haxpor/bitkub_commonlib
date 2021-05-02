#pragma once

namespace bitkub
{

// fee percentage (already applied percentage)
static constexpr double kFeePercentage = 0.0025;
static constexpr const char* kPrefixRedTxt = "\033[1;31m";
static constexpr const char* kPrefixGreenTxt = "\033[1;32m";
static constexpr const char* kPostfixTxt = "\033[0m";

extern const bool g_supportTTY;

/**
 * Intermediate of artifacts as part of computing profits
 */
struct IntermediatedArtifactsProfit
{
	/* Buying fee */
	double buyFee;

	/* Gross amount of gained crypto after buying */
	double grossAmountGainedCrypto;

	/* Net amount of gained crypto after buying */
	double netAmountGainedCrypto;

	/* Gross sell volume */
	double grossSellVolume;

	/* Selling fee in crypto amount */
	double sellFeeCryptoAmount;

	/* Net sell volume */
	double netSellVolume;
};

/**
 * Check if target commandline option exists.
 * Also output found argument index via 'outArgvIndex' if specified.
 */
extern bool FoundCmdOption(int argc, char* argv[], const char* option, int* outArgvIndex=nullptr);

/**
 * Compute both gross and net profit with intermediate returned of results.
 */
extern void ComputeProfit(double amountToSpend, double cryptoBuyPrice, double cryptoSellPrice, double& grossProfit, double& netProfit, IntermediatedArtifactsProfit* artifacts=nullptr);

} // namespace bitkub
